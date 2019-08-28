import { Component, OnInit } from '@angular/core';

import { OrganizationsService } from '../../services/organizations.service';

@Component({
  selector: 'app-organizations',
  templateUrl: './organizations.component.html',
  styleUrls: ['./organizations.component.css']
})
export class OrganizationsComponent implements OnInit {
  loading = true;
  results = null;

  constructor(private os: OrganizationsService) {
  }

  ngOnInit() {    
      this.os.getAll().subscribe((data) => {
      this.loading = false;
      this.results = data;
      //console.log(this.results);
    });
  }
}