import express, { Application } from 'express';
import cors from 'cors';
import { json, urlencoded } from 'body-parser';
import injectDependencies from './dependency-injection';
import apiV1 from './api/routes';

export default class App {
  private app: Application = express();

  initialize() {
    this.app.use(cors());
    this.app.use(json());
    this.app.use(urlencoded({ extended: false }));
    injectDependencies();

    apiV1(this.app);

    const PORT = process.env.PORT ?? 8000;
    this.app.listen(PORT, () => {
      console.log(`running on ${PORT}`);
    });
  }
}
