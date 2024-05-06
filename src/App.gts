import { Component, tracked } from '@lifeart/gxt';
import { Field } from './components/Field';
import { Input } from './components/Input';
import { autofocus } from './modifiers/autofocus';
import { read, write } from './utils/persisted';
import { round } from './utils/round';

export default class App extends Component {
  @tracked minutes = read('minutes', 60);
  @tracked meters = read('meters', 4000);
  @tracked height = read('height', 180);
  @tracked weight = read('weight', 120);
  get km() {
    return this.meters / 1000;
  }
  get mainHours() {
    return parseInt(this.minutes / 60);
  }
  get mainMinutes() {
    return this.minutes % 60;
  }
  get heightISO() {
    return this.height / 100;
  }
  get seconds() {
    return this.minutes * 60;
  }
  get speed() {
    return this.meters / 1000 / (this.minutes / 60);
  }
  get kkcal() {
    const v = this.meters / this.seconds;
    return (
      0.0035 * this.weight + ((v * v) / this.heightISO) * 0.029 * this.weight
    );
  }
  get total() {
    return parseInt(this.kkcal * this.minutes);
  }
  setField = (field: keyof this, e: Event) => {
    const value = e.target.value;
    this[field] = parseInt(value);
    write(field, value);
  };
  <template>
    <section>
      <h1 class='text-orange-300'>Walk Calories</h1>
      <h2 class='mt-2 text-left'>Total:
        <span class='text-lg font-bold'>{{this.total}}</span>
        kcal</h2>
      <h3 class='mt-2 text-left'>
        Speed:
        <span class='text-lg font-bold'>{{round this.speed}}</span>
        km/h</h3>
      <p class='mt-4'>
        <Field
          @value={{this.minutes}}
          @onInput={{fn this.setField 'minutes'}}
          min='10'
          step='5'
          max='240'
        >Duration:
          {{this.mainHours}}
          h
          {{this.mainMinutes}}
          min</Field>

        <Field
          @value={{this.meters}}
          @onInput={{fn this.setField 'meters'}}
          min='100'
          max='20000'
          step='100'
        >
          Distance:
          {{this.km}}
          km
        </Field>

        <Field
          @value={{this.weight}}
          @onInput={{fn this.setField 'weight'}}
          min='45'
          max='180'
        >

          Weight:
          {{this.weight}}
          kg
        </Field>

        <Field
          @value={{this.height}}
          @onInput={{fn this.setField 'height'}}
          min='145'
          max='220'
        >

          Height:
          {{this.height}}
          cm
        </Field>

      </p>
    </section>
    <footer>
      <p class='text-center text-xs text-gray-500'>
        Check on 
        <a href='https://github.com/lifeart/walk-calc/' class='text-blue-500'>GitHub</a>
      </p>
    </footer>
  </template>
}
