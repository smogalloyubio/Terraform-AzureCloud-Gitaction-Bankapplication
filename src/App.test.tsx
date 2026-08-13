import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import App from './App';

describe('App component', () => {
  it('renders without crashing', () => {
    render(<App />);
    // Basic test to ensure the App component renders
    // You might need to add specific selectors based on your App's content
    expect(screen).toBeDefined();
  });
});
