import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Classe } from 'src/app/models/classe.model';
import { Student } from 'src/app/models/student.model';
import { ClasseService } from 'src/app/services/classe.service';
import { StudentService } from 'src/app/services/student.service';

@Component({
  selector: 'app-classe-details',
  templateUrl: './classe-details.component.html',
  styleUrls: ['./classe-details.component.css']
})
export class ClasseDetailsComponent implements OnInit {

  @Input() viewMode = false;
  @Input() currentClasse: Classe = {
    niveau: 0,
    branche: '',
    numero: 0,
    nbEtudiant: 0,
    year: '',
    id:''
  };
  students?: any;
  currentStudent: Student = {};
  currentIndex = -1;

  message = '';
  constructor(
    private classeService: ClasseService,
    private studentService: StudentService,
    private route: ActivatedRoute,
    private router: Router) { }
  ngOnInit(): void {
    if (!this.viewMode) {
      this.getClasse(this.route.snapshot.params["id"]);
      this.retrieveStudents(this.route.snapshot.params["id"]);
    }
  }
  getClasse(id: string): void {
    this.classeService.get(id)
      .subscribe({
        next: (data) => {
          this.currentClasse = data;
          console.log(data);
        },
        error: (e) => console.error(e)
      });
  }
  updateClasse(): void {
    this.message = '';
    this.classeService.update(this.currentClasse.id, this.currentClasse)
      .subscribe({
        next: (res) => {
          console.log(res);
          this.message = res.message ? res.message : 'This Classe was updated successfully!';
        },
        error: (e) => console.error(e)
      });
  }
  setActiveStudent(student: Student, index: number): void {
    this.currentStudent = student;
    this.currentIndex = index;
  }
  deleteClasse(): void {
    this.classeService.delete(this.currentClasse.id)
      .subscribe({
        next: (res) => {
          console.log(res);
          this.router.navigate(['/classes']);
        },
        error: (e) => console.error(e)
      });
  }
  retrieveStudents(id: string): void {
    this.studentService.getByClasse(id)
      .subscribe({
        next: (data) => {
          this.students = data;
          console.log(data);
        },
        error: (e) => console.error(e)
      });
  }

}
