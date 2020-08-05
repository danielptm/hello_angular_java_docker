import {Component, OnInit} from '@angular/core';
import {HttpClient} from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{
  text = '';

  constructor(private http: HttpClient) {}


  ngOnInit(): void {

  }

  click() {
    this.http.get('http://localhost:5000/text', {responseType: 'text'})
      .toPromise()
      .then((res) => {
          this.text = res;
      }, e => { this.text = 'Oops, service must not be working.'; });
  }
}
