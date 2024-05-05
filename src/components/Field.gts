import { Component } from '@lifeart/gxt';

import { Input } from './Input';

export class Field extends Component<{
  Args: { value: string; onInput: (e: Event) => void };
  Element: HTMLInputElement
}> {
  <template>
    <label
      class='text-left block mb-2 text-sm font-medium text-gray-900 dark:text-white'
    >
      {{yield}}
      <Input
        @value={{@value}}
        @onInput={{@onInput}}
        type='range'
        class='w-full mt-2 h-2 mb-6 bg-gray-200 rounded-lg appearance-none cursor-pointer dark:bg-gray-700'
        ...attributes
      />
    </label>
  </template>
}
