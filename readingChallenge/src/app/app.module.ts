import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing/app-routing.module'

import { AppComponent } from './app.component';
import { OrganizationsService } from './services/organizations.service';

import { AdministrationComponent } from './components/administration/administration.component';

@NgModule({
  declarations: [
    AppComponent,
    AdministrationComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [OrganizationsService],
  bootstrap: [AppComponent]
})
export class AppModule { }
