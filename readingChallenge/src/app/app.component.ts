import { Component } from '@angular/core';
import { OrganizationsService } from './services/organizations.service';
import { HammerGestureConfig } from '@angular/platform-browser';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Reading Challenge';  
  content = null;

  constructor(private os: OrganizationsService) {    
  this.content=os.getConfig(); 
  console.log(this.content);
  }  
}
