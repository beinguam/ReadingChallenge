import { Component, OnInit } from '@angular/core';

import { ChallengesService } from 'src/app/services/challenges.service';

@Component({
  selector: 'app-challenges',
  templateUrl: './challenges.component.html',
  styleUrls: ['./challenges.component.css']
})
export class ChallengesComponent implements OnInit {
  loading = true;
  results = null;

  constructor(private cs: ChallengesService) {
  }

  ngOnInit() {
    this.cs.getAll().subscribe((data) => {
      this.loading = false;
      this.results = data;
    });
  }
}
