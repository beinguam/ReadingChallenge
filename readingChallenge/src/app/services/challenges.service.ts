import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ChallengesService {

  constructor(private http: HttpClient) { }

  getAll(): Observable<any> {
    return this.http.get('http://localhost/api/challenges');
  }

  chooseChallenge(id): Observable<any> {
    return this.http.get('http://localhost/api/challenges/organizations/' + id);
  }

  chooseOrganization(id): Observable<any> {
    return this.http.get('http://localhost/api/organizations/challenges/' + id);
  }
}
