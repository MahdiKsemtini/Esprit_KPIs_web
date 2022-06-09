import { Component, OnInit } from '@angular/core';
import { Classe } from 'src/app/models/classe.model';
import { ClasseService } from 'src/app/services/classe.service';

@Component({
  selector: 'app-add-classe',
  templateUrl: './add-classe.component.html',
  styleUrls: ['./add-classe.component.css']
})
export class AddClasseComponent implements OnInit {

  classe: Classe = {
    niveau: 1,
    branche: '',
    numero: 1,
    nbEtudiant: 1,
    year: ''
  };
  submitted = false;
  badRequest: boolean = false;
  constructor(private classeService: ClasseService) { }

  ngOnInit(): void {
  }

  saveClasse(): void {
    const data = {
      niveau: this.classe.niveau,
      branche: this.classe.branche,
      numero: this.classe.numero,
      nbEtudiant: this.classe.nbEtudiant,
      year: this.classe.year
    };
    this.classeService.create(data)
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
  newClasse(): void {
    this.submitted = false;
    this.classe = {
      niveau: 1,
      branche: '',
      numero: 1,
      nbEtudiant: 1,
      year: ''
    };
  }

}
