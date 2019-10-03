import { Component, OnInit } from '@angular/core';

import { UsersService } from 'src/app/services/users.service';
import { Users } from '../../models/users-model';
import { Organizations } from 'src/app/models/organizations-model';
import { OrganizationsService } from '../../services/organizations.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  results: Users[];
  userResults: Organizations[];  

  constructor(private us: UsersService, private os: OrganizationsService) {
  }

  ngOnInit() {   
    console.log(sessionStorage.getItem('orgId'));
    this.us.getAll().subscribe((data) => {
      this.results = data;
    });
  }  


  //getUsers(this.orgId).subscribe((data) => {
  //  this.results = data;      
  //});
  //}
}
