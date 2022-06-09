import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
//Componenet

import { SigninComponent } from './componenet/signin/signin.component';
import { TasksComponent } from './componenet/tasks/tasks.component';
import { DashboardComponent } from './componenet/dashboard/dashboard.component';
import { AddClasseComponent } from './components/add-classe/add-classe.component';
import { AddStudentComponent } from './components/add-student/add-student.component';
import { ClasseDetailsComponent } from './components/classe-details/classe-details.component';
import { ClassesListComponent } from './components/classes-list/classes-list.component';
import { ImportStudentsComponent } from './components/import-students/import-students.component';
import { StudentDetailsComponent } from './components/student-details/student-details.component';
import { StudentsListComponent } from './components/students-list/students-list.component';
import { StudentsStatisticsComponent } from './components/students-statistics/students-statistics.component';

const routes: Routes = [

  { path: 'students', component: StudentsListComponent },
  { path: 'students/:id', component: StudentDetailsComponent },
  { path: 'addStudent', component: AddStudentComponent },
  { path: 'classes', component: ClassesListComponent },
  { path: 'classes/:id', component: ClasseDetailsComponent },
  { path: 'addClasse', component: AddClasseComponent },
  { path: 'importStudents', component: ImportStudentsComponent },
  { path: 'studentsStatistics', component: StudentsStatisticsComponent },


  {
    path: '',
    redirectTo: '/signin',
    pathMatch: 'full'
  },

  {
    path: 'signin',
    component: SigninComponent
  },
  {
    path: 'tasks',
    component: TasksComponent
  },
  {
    path: 'dashboard',
    component: DashboardComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
