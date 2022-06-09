import { Component, OnInit } from '@angular/core';
import { Student } from 'src/app/models/student.model';
import { StudentService } from 'src/app/services/student.service';

@Component({
  selector: 'app-add-student',
  templateUrl: './add-student.component.html',
  styleUrls: ['./add-student.component.css']
})
export class AddStudentComponent implements OnInit {

  student: Student = {
    cin: '',
    firstName: '',
    lastName: '',
    email: '',
    birthDate: '',
    phone: ''
  };
  submitted = false;
  badRequest: boolean = false;
  constructor(private studentService: StudentService) { }
  ngOnInit(): void {
  }
  saveStudent(): void {
    const data = {
      cin: this.student.cin,
      firstName: this.student.firstName,
      lastName: this.student.lastName,
      email: this.student.email,
      birthDate: this.student.birthDate,
      phone: this.student.phone
    };
    this.studentService.create(data)
      .subscribe({
        next: (res) => {
          console.log(res);
          this.submitted = true;
        },
        error: (e) => {
          console.error(e)
          if(e.status == 500){
            this.badRequest = true;
          }
        }
      });
  }
  newStudent(): void {
    this.submitted = false;
    this.student = {
      cin: '',
      firstName: '',
      lastName: '',
      email: '',
      birthDate: '',
      phone: ''
    };
  }

}
