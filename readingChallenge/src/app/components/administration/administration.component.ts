import { Component, OnInit } from '@angular/core';

import { OrganizationsService } from '../../services/organizations.service';
import { Organizations } from '../../models/organizations-model';

@Component({
  selector: 'app-administration',
  templateUrl: './administration.component.html',
  styleUrls: ['./administration.component.css']
})
export class AdministrationComponent implements OnInit {
  results: Organizations[];
  userId = 1;

  constructor(private os: OrganizationsService) {
  }

  ngOnInit() {
    this.os.getOrganization(this.userId).subscribe((data) => {
      this.results = data;
      console.log(this.results);
    });
  }

}
