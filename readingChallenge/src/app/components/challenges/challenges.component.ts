import { Component, OnInit } from '@angular/core';

import { ChallengesService } from 'src/app/services/challenges.service';
import { Challenges } from '../../models/challenges-model';
import { Organizations } from 'src/app/models/organizations-model';

@Component({
  selector: 'app-challenges',
  templateUrl: './challenges.component.html',
  styleUrls: ['./challenges.component.css']
})
export class ChallengesComponent implements OnInit {
  results: Challenges[];
  orgResults: Organizations[];
  orgId: number;

  constructor(private challenges: ChallengesService) {
  }

  ngOnInit() {
    this.challenges.getAll().subscribe((data) => {
      this.results = data;
    });
  }

  choseChallenge(event: { target: { value: string; }; }) {    
    sessionStorage.setItem("orgId", event.target.value);
    
    this.challenges.chooseOrganization(event.target.value).subscribe((data) => {
      this.orgResults = data;         
    });
  }
}
