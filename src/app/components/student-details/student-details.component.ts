import { Component, Input, OnInit } from '@angular/core';
import { Student } from 'src/app/models/student.model';
import { ActivatedRoute, Router } from '@angular/router';
import { StudentService } from 'src/app/services/student.service';
import { ClasseService } from 'src/app/services/classe.service';
import { Classe } from 'src/app/models/classe.model';

@Component({
  selector: 'app-student-details',
  templateUrl: './student-details.component.html',
  styleUrls: ['./student-details.component.css']
})
export class StudentDetailsComponent implements OnInit {

  @Input() viewMode = false;
  @Input() currentStudent: Student = {
    cin: '',
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    password: '',
    birthDate: '',
    photo: ''
  };


  classes?: Classe[];
  message = '';
  niveau :any
  branche:any
  numero:any
  year:any
  constructor(
    private studentService: StudentService,
    private classeService: ClasseService,
    private route: ActivatedRoute,
    private router: Router) { }

    submitted = false;
  ngOnInit(): void {
    if (!this.viewMode) {
      this.getStudent(this.route.snapshot.params["id"]);
      this.retrieveClasses();
    }
  }
  getStudent(id: string): void {
    this.studentService.get(id)
      .subscribe({
        next: (data) => {
          this.currentStudent = data;
          this.niveau=this.currentStudent.classe?.niveau
          this.branche=this.currentStudent.classe?.branche
          this.numero=this.currentStudent.classe?.numero
          this.year=this.currentStudent.classe?.year
          console.log(this.currentStudent);
          console.log(this.currentStudent.photo);
        },
        error: (e) => console.error(e)
      });
  }
  retrieveClasses(): void {
    this.classeService.getAll()
      .subscribe({
        next: (data) => {
          this.classes = data;
          console.log(data);
        },
        error: (e) => console.error(e)
      });
  }
  updateStudent(): void {
    this.message = '';
    this.studentService.update(this.currentStudent.id, this.currentStudent)
      .subscribe({
        next: (res) => {
          console.log(res);
          this.message = res.message ? res.message : 'This student was updated successfully!'; 
          
          this.niveau=res.classe.niveau
          this.branche=res.classe.branche
          this.numero=res.classe.numero
          this.year=res.classe.year
          this.submitted = true;
        },
        error: (e) => console.error(e)
      });
  }
  deleteStudent(): void {
    this.studentService.delete(this.currentStudent.id)
      .subscribe({
        next: (res) => {
          console.log(res);
          this.router.navigate(['/students']);
        },
        error: (e) => console.error(e)
      });
  }
  reloadCurrentPage() {
    window.location.reload();
   }
}
