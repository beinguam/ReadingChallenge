import { Component, OnInit } from '@angular/core';

import { Users } from '../../models/users-model';
import { UsersService } from 'src/app/services/users.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit {
  orgId = 1;
  userId = 1;
  result: Users;

  constructor(private us: UsersService) {
  }

  ngOnInit() {
    this.us.getUser(this.userId).subscribe((data) => {
      this.result = data;
    });
  }

}
