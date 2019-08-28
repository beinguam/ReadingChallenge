import { Component } from '@angular/core';
import { OrganizationsService } from './services/organizations.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Reading Challenge';  
  loading = null;
  results = null;

  constructor(private os: OrganizationsService) {
    this.loading = true;
    this.os.getAll().subscribe((data) => {
      this.loading = false;
      this.results = data;
      console.log(this.results);
      });
    
  }  
}