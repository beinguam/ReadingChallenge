import { Injectable } from '@angular/core';

import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class OrganizationsService {

  constructor(private http: HttpClient) { }

  getAll<T>(): Observable<T> {  
    return this.http.get<T>("http://localhost/api/organizations");  
}
}