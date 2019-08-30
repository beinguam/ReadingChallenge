import { Component, OnInit } from '@angular/core';

import { OrganizationsService } from '../../services/organizations.service';

@Component({
  selector: 'app-administration',
  templateUrl: './administration.component.html',
  styleUrls: ['./administration.component.css']
})
export class AdministrationComponent implements OnInit {
  loading = true;
  results = null;

  constructor(private os: OrganizationsService) {
  }

  ngOnInit() {
    this.os.getAll().subscribe((data) => {
      this.loading = false;
      this.results = data;
    });
  }

}
