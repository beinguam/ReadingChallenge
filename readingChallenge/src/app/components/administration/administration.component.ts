import { Component, OnInit } from '@angular/core';

import { OrganizationsService } from '../../services/organizations.service';
import { Organizations } from '../../models/organizations-model';
import { ChallengesService } from 'src/app/services/challenges.service';
import { Challenges } from 'src/app/models/challenges-model';

@Component({
  selector: 'app-administration',
  templateUrl: './administration.component.html',
  styleUrls: ['./administration.component.css']
})
export class AdministrationComponent implements OnInit {
  results: Organizations[];
  userId = 1;
  chalResults: Challenges[];

  constructor(private os: OrganizationsService, private challenges: ChallengesService) {
  }

  ngOnInit() {
    this.os.getOrganization(this.userId).subscribe((data) => {
      this.results = data;      
    });
  }

  choseOrganization() {
    this.challenges.chooseChallenge(this.userId).subscribe((data) => {
      this.chalResults = data;      
      console.log(this.chalResults);
    });
  }
}
