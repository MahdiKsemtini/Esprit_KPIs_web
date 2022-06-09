import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { Classe } from '../models/classe.model';
const baseUrl = 'http://localhost:3000/classes';

@Injectable({
  providedIn: 'root'
})
export class ClasseService {
  static getById(classe: string | undefined) {
    throw new Error('Method not implemented.');
  }

  constructor(private http: HttpClient) { }
  getAll(): Observable<Classe[]> {
    return this.http.get<Classe[]>(baseUrl);
  }
  get(id: any): Observable<Classe> {
    return this.http.get(`${baseUrl}/${id}`);
  }
  getById(id: any): Observable<Classe> {
    return this.http.get(`${baseUrl}/${id}`);
  }
  create(data: any): Observable<any> {
    return this.http.post(`${baseUrl}/create`, data);
  }
  update(id: any, data: any): Observable<any> {
    return this.http.put(`${baseUrl}/${id}`, data);
  }
  delete(id: any): Observable<any> {
    return this.http.delete(`${baseUrl}/${id}`);
  }
  getNbClasseByNiveau(): Observable<any> {
    return this.http.get(`${baseUrl}/nv`);
  }
}