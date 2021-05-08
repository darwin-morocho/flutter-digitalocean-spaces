import DigitalOceanSpace from './data/data-sources/remote/digital-ocean-space';
import StorageRepositoryImpl from './data/repositories-impl/storage-repository-impl';
import StorageRepository from './domain/repositories/storage-repository';
import Get from './helpers/get';

export enum Dependencies {
  storage = 'storage',
  users = 'users',
}

const injectDependencies = () => {
  const storage = new DigitalOceanSpace();
  Get.put<StorageRepository>(
    new StorageRepositoryImpl(storage),
    Dependencies.storage
  );
};

export default injectDependencies;
