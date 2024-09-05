import { getConfig } from '../../../core/config';

export interface IStringToStringDictionary { [key: string]: string|number|undefined; }
export class ConfigController {
  public getAllParam(): any {
    const config = getConfig();
    return {
      host: 'some-host',
      port: 'some-port'
    };
  }
}