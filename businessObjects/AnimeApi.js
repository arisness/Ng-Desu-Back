export class AnimeApi {
  constructor() {
    this.baseUrl = 'https://graphql.anilist.co';
    this.defaultHeaders = {
      'Content-Type': 'application/json',
      Accept: 'application/json'
    };
  }

  async search(data = {}) {
    const searchText = data.searchText || data.query || '';
    const page = Number(data.page) || 1;
    const perPage = Number(data.perPage) || 10;
    const sort = this.normalizeSort(data.sort || 'POPULARITY_DESC');
    const genre = data.genre || null;

    const response = await this.request(
      {
        query: `
          query ($search: String, $page: Int, $perPage: Int, $sort: [MediaSort], $type: MediaType, $genre: String) {
            Page(page: $page, perPage: $perPage) {
              pageInfo {
                total
                currentPage
                hasNextPage
                lastPage
              }
              media(search: $search, type: $type, sort: $sort, genre: $genre) {
                id
                title {
                  romaji
                  english
                  native
                  userPreferred
                }
                coverImage {
                  large
                  medium
                }
                description
                episodes
                averageScore
                genres
                format
                status
                startDate {
                  year
                  month
                  day
                }
                endDate {
                  year
                  month
                  day
                }
                siteUrl
              }
            }
          }
        `,
        variables: {
          search: searchText,
          page,
          perPage,
          sort,
          type: 'ANIME',
          genre
        }
      },
      data
    );

    return {
      pageInfo: response?.data?.Page?.pageInfo || null,
      media: response?.data?.Page?.media || []
    };
  }

  async getAnimeById(data = {}) {
    if (!data.animeId) {
      throw new Error('Se requiere animeId');
    }

    const animeId = Number(data.animeId);

    if (Array.isArray(data.searchResults)) {
      const fromSearch = data.searchResults.find(
        (item) => String(item.id) === String(animeId)
      );

      if (fromSearch) {
        return fromSearch;
      }
    }

    const response = await this.request(
      {
        query: `
          query ($id: Int, $type: MediaType) {
            Media(id: $id, type: $type) {
              id
              title {
                romaji
                english
                native
                userPreferred
              }
              coverImage {
                large
                medium
              }
              description
              episodes
              averageScore
              genres
              format
              status
              startDate {
                year
                month
                day
              }
              endDate {
                year
                month
                day
              }
              siteUrl
            }
          }
        `,
        variables: {
          id: animeId,
          type: 'ANIME'
        }
      },
      data
    );

    return response?.data?.Media || null;
  }

  async request(payload, data = {}) {
    if (typeof fetch !== 'function') {
      throw new Error('fetch no está disponible. Usa Node 18+ o un polyfill.');
    }

    const headers = {
      ...this.defaultHeaders
    };

    if (data.userSession) {
      headers.Authorization = `Bearer ${data.userSession}`;
    }

    const response = await fetch(this.baseUrl, {
      method: 'POST',
      headers,
      body: JSON.stringify(payload)
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`AniList request failed: ${response.status} ${errorText}`);
    }

    const json = await response.json();

    if (json.errors) {
      throw new Error(JSON.stringify(json.errors));
    }

    return json;
  }

  normalizeSort(sort) {
    const allowed = new Set([
      'SEARCH_MATCH',
      'POPULARITY',
      'POPULARITY_DESC',
      'START_DATE',
      'START_DATE_DESC',
      'STATUS',
      'STATUS_DESC'
    ]);

    const normalizeValue = (value) => {
      if (typeof value !== 'string') return null;

      const cleaned = value
        .trim()
        .toUpperCase()
        .replace(/-/g, '_')
        .replace(/\s+/g, '_');

      if (allowed.has(cleaned)) {
        return cleaned;
      }

      return null;
    };

    if (!sort) {
      return ['POPULARITY_DESC'];
    }

    const values = Array.isArray(sort) ? sort : [sort];
    const normalized = values.map(normalizeValue).filter(Boolean);

    return normalized.length ? normalized : ['POPULARITY_DESC'];
  }
}