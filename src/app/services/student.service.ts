import { Injectable } from '@angular/core';
import { HttpClient, HttpEvent, HttpRequest } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Student } from '../models/student.model';
const baseUrl = 'http://localhost:3000/students';

@Injectable({
  providedIn: 'root'
})
export class StudentService {
  constructor(private http: HttpClient) { }
  getAll(): Observable<Student[]> {
    return this.http.get<Student[]>(baseUrl);
  }
  get(id: any): Observable<Student> {
    return this.http.get(`${baseUrl}/${id}`);
  }
  getByClasse(idClasse: any): Observable<Student[]> {
    return this.http.get<Student[]>(`${baseUrl}/classe/${idClasse}`);
  }
  getNbStudentsByClasse(): Observable<any> {
    return this.http.get(`${baseUrl}/nb`);
  }
  create(data: any): Observable<any> {
    return this.http.post(`${baseUrl}/register`, data);
  }
  update(id: any, data: any): Observable<any> {
    return this.http.put(`${baseUrl}/${id}`, data);
  }
  delete(id: any): Observable<any> {
    return this.http.delete(`${baseUrl}/${id}`);
  }
  upload(file: File): Observable<HttpEvent<any>> {
    const formData: FormData = new FormData();
    formData.append('uploadfile', file);
    const req = new HttpRequest('POST', `${baseUrl}/uploadstudents`, formData, {
      reportProgress: true,
      responseType: 'json'
    });
    return this.http.request(req);
  }
  findByEmail(email: any): Observable<Student[]> {
    return this.http.get<Student[]>(`${baseUrl}?email=${email}`);
  }
}
