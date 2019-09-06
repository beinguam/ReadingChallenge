import { Component, OnInit } from '@angular/core';

import { UsersService } from 'src/app/services/users.service';
import { Users } from '../../models/users-model';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  results: Users[];

  constructor(private us: UsersService) {
  }

  ngOnInit() {
    this.us.getAll().subscribe((data) => {
      this.results = data;
    });
  }

}
