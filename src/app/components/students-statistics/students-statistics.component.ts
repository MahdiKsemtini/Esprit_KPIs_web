import { Component, OnInit } from '@angular/core';
import { ChartOptions } from 'chart.js';
import { StudentService } from 'src/app/services/student.service';
import { Chart, registerables } from 'chart.js';
import { ClasseService } from 'src/app/services/classe.service';

@Component({
  selector: 'app-students-statistics',
  templateUrl: './students-statistics.component.html',
  styleUrls: ['./students-statistics.component.css']
})
export class StudentsStatisticsComponent implements OnInit {

  students?: any;
  classes?: any;
  nb: Number[] = [];
  classe: String[] = [];
  nv: Number[] = [];
  nbClasse: Number[] = [];
  chart1: any = [];
  chart2: any = [];
  page: number = 1;
  count: number = 0;
  newStudents:any;
  nbStudentsTotal:number=0;
  nbClassesTotal:number=0;
  avg:number=0;
  x:number=0;
  y:number=0;


  constructor(private studentService: StudentService,private classeService: ClasseService) { }

  ngOnInit(): void {
    this.getNbStudentsByClasse();
    this.getNbClasseByNiveau();
  }

  getNbStudentsByClasse(): void {
    this.studentService.getNbStudentsByClasse()
      .subscribe({
        next: (data) => {
          this.students = data;
          this.students.forEach((student: { nbStudents: number; _id: { name: String; }; }) => {
            if (student._id?.name == null) {
              this.classe.push('none')
              this.nb.push(student.nbStudents);
              this.newStudents=student.nbStudents;
            }
            else {
              this.nb.push(student.nbStudents);
              this.classe.push(student._id?.name)
              this.x=this.x+student.nbStudents
              this.y=this.y+1
            }
            this.nbStudentsTotal=this.nbStudentsTotal+student.nbStudents
          });
          this.avg = (this.x / this.y)
          this.chart1 = new Chart('canvas1', {
            type: 'bar',
            data: {
              labels: this.classe,
              datasets: [
                {
                  data: this.nb,
                  borderColor: '#cf171f',
                  label: 'Numbre of Students by class',
                  backgroundColor: '#b2b3b7',
                  borderWidth: 3,
                },
              ],
            },
          });
          console.log(this.nb);
          console.log(this.classe);
        },
        error: (e) => console.error(e)
      });
  }


  getNbClasseByNiveau(): void {
    this.classeService.getNbClasseByNiveau()
      .subscribe({
        next: (data) => {
          this.classes = data;
          this.classes.forEach((classe: { niveau: Number; nbClasse: number; }) => {
            this.nv.push(classe.niveau);
            this.nbClasse.push(classe.nbClasse)
            this.nbClassesTotal=this.nbClassesTotal+ classe.nbClasse;
          });
          this.chart2 = new Chart('canvas2', {
            type: 'bar',
            data: {
              labels: this.nv,
              datasets: [
                {
                  data: this.nbClasse,
                  borderColor: '#cf171f',
                  label: 'Numbre of Classes',
                  backgroundColor: '#b2b3b7',
                  borderWidth: 3,
                },
              ],
            },
            options: {
              indexAxis: 'y',
              // Elements options apply to all of the options unless overridden in a dataset
              // In this case, we are setting the border of each horizontal bar to be 2px wide
              elements: {
                bar: {
                  borderWidth: 2,
                }
              },
              responsive: true,
              plugins: {
                legend: {
                  position: 'right',
                },
                title: {
                  display: true,
                  text: 'Numbre of Classes by level'
                }
              }
            },
          });
          console.log(this.nv);
          console.log(this.nbClasse);
        },
        error: (e) => console.error(e)
      });
  }
  
  onTableDataChange(event: any) {
    this.page = event;
    this.getNbStudentsByClasse();
  }

}
