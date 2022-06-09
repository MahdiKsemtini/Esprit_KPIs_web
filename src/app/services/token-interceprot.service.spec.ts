import { TestBed } from '@angular/core/testing';

import { TokenInterceprotService } from './token-interceprot.service';

describe('TokenInterceprotService', () => {
  let service: TokenInterceprotService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TokenInterceprotService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
