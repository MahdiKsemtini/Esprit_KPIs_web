import { Component, OnInit } from '@angular/core';
import { Classe } from 'src/app/models/classe.model';
import { ClasseService } from 'src/app/services/classe.service';

@Component({
  selector: 'app-classes-list',
  templateUrl: './classes-list.component.html',
  styleUrls: ['./classes-list.component.css']
})
export class ClassesListComponent implements OnInit {

  classes?: any;
  currentClasse: Classe = {};
  currentIndex = -1;
  name = '';
  page: number = 1;
  count: number = 0;
  constructor(private classeService: ClasseService) { }
  ngOnInit(): void {
    this.retrieveClasses();
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
  refreshList(): void {
    this.retrieveClasses();
    this.currentClasse = {};
    this.currentIndex = -1;
  }
  setActiveClasse(classe: Classe, index: number): void {
    this.currentClasse = classe;
    this.currentIndex = index;
  }
  onTableDataChange(event: any) {
    this.page = event;
    this.retrieveClasses();
  }

}
