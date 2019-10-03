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

  choseOrganization(event: { target: { value: number; }; }) {        
    this.challenges.chooseChallenge(event.target.value).subscribe((data) => {
      this.chalResults = data;         
    });
  }
}
