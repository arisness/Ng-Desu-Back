export class Status {
    async addStatus(data) {
         try{
            await runQuery([[queries.status.addStatus, [data.userSession, data.animeId, data.status]]]);
            return 'Status added successfully';
         } catch (error) {
            logger.error('Error adding status:', error);
            return 'Error adding status';
         }
    }

    async getStatus(data) {
        try {
            const result = await runQuery([[queries.status.getStatus, [data.userSession]]]);
            return result.rows;
        } catch (error) {
            logger.error('Error fetching status:', error);
            return 'Error fetching status';
        }
    }

    async deleteStatus(data) {
        try {
            await runQuery([[queries.status.deleteStatus, [data.userSession, data.animeId]]]);
            return 'Status deleted successfully';
        } catch (error) {
            logger.error('Error deleting status:', error);
            return 'Error deleting status';
        }
    }

    async updateStatus(data) {
        try {
            await runQuery([[queries.status.updateStatus, [data.status, data.userSession, data.animeId]]]);
            return 'Status updated successfully';
        } catch (error) {
            logger.error('Error updating status:', error);
            return 'Error updating status';
        }
    }  
}