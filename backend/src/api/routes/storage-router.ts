import express, { Router } from 'express';
import StorageController from '../controllers/storage-controller';

export default (): Router => {
  const router = express.Router();
  const controller = new StorageController();
  router.post('/get-pre-signed-upload-url', controller.getUploadUrl);
  router.post('/delete', controller.deleteFile);
  router.post('/get-signed-url', controller.getSignedURL);
  return router;
};
