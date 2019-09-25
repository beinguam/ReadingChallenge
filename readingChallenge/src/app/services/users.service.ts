import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UsersService {

  constructor(private http: HttpClient) { }

  getAll(): Observable<any> {
    return this.http.get('http://localhost/api/users');
}
  getUser(id: number): Observable<any> {
    return this.http.get('http://localhost/api/users/' + id);
  }
}
