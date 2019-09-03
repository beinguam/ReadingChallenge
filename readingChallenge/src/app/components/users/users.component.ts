import { Component, OnInit } from '@angular/core';

import { UsersService } from 'src/app/services/users.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  loading = true;
  results = null;

  constructor(private us: UsersService) {
  }

  ngOnInit() {
    this.us.getAll().subscribe((data) => {
      this.loading = false;
      this.results = data;
    });
  }

}
