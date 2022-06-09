import { Component, OnInit } from '@angular/core';
import { Student } from 'src/app/models/student.model';
import { StudentService } from 'src/app/services/student.service';

@Component({
  selector: 'app-students-list',
  templateUrl: './students-list.component.html',
  styleUrls: ['./students-list.component.css']
})
export class StudentsListComponent implements OnInit {

  students?: any;
  currentStudent: Student = {};
  currentIndex = -1;
  email = '';
  page: number = 1;
  count: number = 0;
  constructor(private studentService: StudentService) { }
  ngOnInit(): void {
    this.retrieveStudents();
  }
  retrieveStudents(): void {
    this.studentService.getAll()
      .subscribe({
        next: (data) => {
          this.students = data;
          console.log(data);
        },
        error: (e) => console.error(e)
      });
  }
  refreshList(): void {
    this.retrieveStudents();
    this.currentStudent = {};
    this.currentIndex = -1;
  }
  onTableDataChange(event: any) {
    this.page = event;
    this.retrieveStudents();
  }
  setActiveStudent(student: Student, index: number): void {
    this.currentStudent = student;
    this.currentIndex = index;
  }
  searchEmail(): void {
    this.currentStudent = {};
    this.currentIndex = -1;
    this.studentService.findByEmail(this.email)
      .subscribe({
        next: (data) => {
          this.students = data;
          console.log(data);
        },
        error: (e) => console.error(e)
      });
  }

}
