import { Component, OnInit } from '@angular/core';

import { ChallengesService } from 'src/app/services/challenges.service';
import { Challenges } from '../../models/challenges-model';

@Component({
  selector: 'app-challenges',
  templateUrl: './challenges.component.html',
  styleUrls: ['./challenges.component.css']
})
export class ChallengesComponent implements OnInit {
  results: Challenges[];

  constructor(private cs: ChallengesService) {
  }

  ngOnInit() {
    this.cs.getAll().subscribe((data) => {
      this.results = data;
    });
  }
}
