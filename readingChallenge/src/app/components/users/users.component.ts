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
  orgResults: Organizations[];  
  orgId: string;  

  constructor(private us: UsersService, private os: OrganizationsService) {
  }

  ngOnInit() {       
    this.us.getAll().subscribe((data) => {
      this.results = data;
    });
  }

  choseUser(event: { target: { value: string; }; }){
    this.us.getUsers(event.target.value).subscribe((data) => {
      this.orgResults = data;
    });
  }
}
