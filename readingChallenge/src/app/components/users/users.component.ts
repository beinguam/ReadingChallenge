import { Component, OnInit } from '@angular/core';

import { UsersService } from 'src/app/services/users.service';
import { Users } from '../../models/users-model';
import { Organizations } from 'src/app/models/organizations-model';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  results: Users[];
  userResults: Organizations[];

  constructor(private us: UsersService) {
  }

  ngOnInit() {
    this.us.getAll().subscribe((data) => {
      this.results = data;
    });
  }
  choseUser(event: { target: { value: number; }; }) {        
    this.us.getOrganizations(event.target.value).subscribe((data) => {
      this.userResults = data;       
      console.log(data);
    });
  }
}
