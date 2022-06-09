import { Injectable } from '@angular/core';
import{HttpClient} from '@angular/common/http';
import {Router} from '@angular/router'

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private URL ='http://localhost:3000/Kpii/admin'

  constructor( private http:HttpClient,
    private router : Router
    ) { } 

  signIn(admin: {}){
    return this.http.post<any>(this.URL + '/login', admin)
   
  }
  loggedIn(){
    return !!localStorage.getItem('token')
  }
  logout(){
    localStorage.removeItem('token')
    this.router.navigate(['/login'])
    
  }



}
