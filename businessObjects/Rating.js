export class Rating {
    async addRating(data) {
         try{
            await runQuery([[queries.rating.addRating, [data.userSession, data.animeId, data.rating, data.comment]]]);
            return 'Rating added successfully';
         } catch (error) {
            logger.error('Error adding rating:', error);
            return 'Error adding rating';
         }
    }

    async getRating(data) {
        try {
            const result = await runQuery([[queries.rating.getRating, [data.animeId]]]);
            return result;
        } catch (error) {
            logger.error('Error fetching rating and comment:', error);
            return 'Error fetching rating and comment';
        }
    }

    async deleteRating(data) {
        try {
            await runQuery([[queries.rating.deleteRating, [data.userSession, data.animeId]]]);
            return 'Rating deleted successfully';
        } catch (error) {
            logger.error('Error deleting rating:', error);
            return 'Error deleting rating';
        }
    }

    async updateRating(data) {
        try {
            await runQuery([[queries.rating.updateRating, [data.rating, data.comment, data.userSession, data.animeId]]]);
            return 'Rating updated successfully';
        } catch (error) {
            logger.error('Error updating rating:', error);
            return 'Error updating rating';
        }
    }  
}