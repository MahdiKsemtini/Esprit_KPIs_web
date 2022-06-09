import { Component, OnInit } from '@angular/core';
import {AuthService} from '../../services/auth.service'
import {Router} from '@angular/router'
import { Admin } from 'src/app/admin';


@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html',
  styleUrls: ['./signin.component.css']
})
export class SigninComponent implements OnInit {

  admin = new Admin();

  constructor( 
    private authService : AuthService ,
    private router : Router
    ) { }

  ngOnInit(): void {
  }

  signIn(){
     this.authService.signIn(this.admin)
     .subscribe(
       res => {
         console.log(res)
         localStorage.setItem('token',res.token);
         this.router.navigate(['/dashboard']);
       },
       error =>  console.log(error)
     )
  }

}
