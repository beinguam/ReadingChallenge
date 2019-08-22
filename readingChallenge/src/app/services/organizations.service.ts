import { Injectable } from '@angular/core';

import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class OrganizationsService {

  constructor(private http: HttpClient) { }

configUrl = 'http://localhost/api/organizations';

getConfig() {  
  return this.http.get(this.configUrl);
}
}