import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StudentsStatisticsComponent } from './students-statistics.component';

describe('StudentsStatisticsComponent', () => {
  let component: StudentsStatisticsComponent;
  let fixture: ComponentFixture<StudentsStatisticsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StudentsStatisticsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StudentsStatisticsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
