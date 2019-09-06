import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing/app-routing.module'

import { AppComponent } from './app.component';
import { OrganizationsService } from './services/organizations.service';

import { AdministrationComponent } from './components/administration/administration.component';
import { UsersComponent } from './components/users/users.component';
import { ChallengesComponent } from './components/challenges/challenges.component';
import { UsersService } from './services/users.service';
import { ChallengesService } from './services/challenges.service';

@NgModule({
  declarations: [
    AppComponent,
    AdministrationComponent,
    UsersComponent,
    ChallengesComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [OrganizationsService, UsersService, ChallengesService],
  bootstrap: [AppComponent]
})
export class AppModule { }
