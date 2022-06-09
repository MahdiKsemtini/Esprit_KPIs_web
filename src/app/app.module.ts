import { NgModule, CUSTOM_ELEMENTS_SCHEMA  } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import {FormsModule,ReactiveFormsModule} from '@angular/forms'
import {HttpClientModule} from '@angular/common/http'

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
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
import { NgxPaginationModule } from 'ngx-pagination';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgChartsModule } from 'ng2-charts';

@NgModule({
  declarations: [
    AppComponent,
    SigninComponent,
    TasksComponent,
    DashboardComponent,
    AddClasseComponent,
    AddStudentComponent,
    ClasseDetailsComponent,
    ClassesListComponent,
    ImportStudentsComponent,
    StudentDetailsComponent,
    StudentsListComponent,
    StudentsStatisticsComponent,
  
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    NgxPaginationModule,
    NgChartsModule,
  ],
  providers: [],
  bootstrap: [AppComponent],
  schemas: [ CUSTOM_ELEMENTS_SCHEMA ]
})
export class AppModule { }
