import { Application } from 'express';
import storageRouter from './storage-router';

const apiV1 = (app: Application) => {
  app.get('/', (req, res) => res.send('HELLO 😅'));
  app.use('/api', storageRouter());
};

export default apiV1;
