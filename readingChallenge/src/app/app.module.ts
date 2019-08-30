import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';

import { AppComponent } from './app.component';
import { OrganizationsService } from './services/organizations.service';
import { OrganizationsComponent } from './components/organizations/organizations.component';
import { BooksComponent } from './components/books/books/books.component';
import { AdministrationComponent } from './components/administration/administration.component';

@NgModule({
  declarations: [
    AppComponent,
    OrganizationsComponent,
    BooksComponent,
    AdministrationComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule
  ],
  providers: [OrganizationsService],
  bootstrap: [AppComponent]
})
export class AppModule { }
