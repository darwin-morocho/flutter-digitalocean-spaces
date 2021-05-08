export interface GetPreSignedUploadURL {
  Key: string;
  ContentType: string;
  ACL: 'public-read' | 'private';
}

export default interface StorageRepository {
  getPreSignedUploadURL(data: GetPreSignedUploadURL): string;
  deleteFile(key: string): Promise<boolean>;
  getSignedURL(key: string): string;
}
