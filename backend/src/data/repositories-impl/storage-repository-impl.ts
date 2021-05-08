import StorageRepository, {
  GetPreSignedUploadURL,
} from '../../domain/repositories/storage-repository';
import DigitalOceanSpace from '../data-sources/remote/digital-ocean-space';

export default class StorageRepositoryImpl implements StorageRepository {
  constructor(readonly storage: DigitalOceanSpace) {}
  getSignedURL(key: string): string {
    return this.storage.getSignedURL(key);
  }

  deleteFile(key: string): Promise<boolean> {
    return this.storage.deleteFile(key);
  }

  getPreSignedUploadURL(data: GetPreSignedUploadURL): string {
    return this.storage.getPreSignedUrlToUpload(data);
  }
}
