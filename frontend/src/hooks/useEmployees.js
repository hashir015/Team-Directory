import { useState, useEffect, useCallback } from 'react';
import * as api from '../services/api';

/**
 * Custom hook for managing employees data and CRUD operations
 * 
 * Follows React best practices:
 * - useCallback for memoized handlers
 * - useEffect for data fetching on mount
 * - Proper loading and error state management
 * 
 * @returns {object} Employees state and CRUD handlers
 */
export function useEmployees() {
    // State management
    const [employees, setEmployees] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    /**
     * Fetch all employees from API
     */
    const loadEmployees = useCallback(async () => {
        setLoading(true);
        setError(null);

        try {
            const data = await api.fetchEmployees();
            setEmployees(data);
        } catch (err) {
            console.error('Failed to fetch employees:', err);
            setError(err.message);
        } finally {
            setLoading(false);
        }
    }, []);

    /**
     * Create a new employee
     * @param {object} employeeData - { firstName, lastName, role }
     */
    const addEmployee = useCallback(async (employeeData) => {
        try {
            await api.createEmployee(employeeData);
            await loadEmployees(); // Refresh the list
            return { success: true };
        } catch (err) {
            console.error('Failed to create employee:', err);
            return { success: false, error: err.message };
        }
    }, [loadEmployees]);

    /**
     * Update an existing employee
     * @param {number} id - Employee ID
     * @param {object} employeeData - Updated data
     */
    const editEmployee = useCallback(async (id, employeeData) => {
        try {
            await api.updateEmployee(id, employeeData);
            await loadEmployees(); // Refresh the list
            return { success: true };
        } catch (err) {
            console.error('Failed to update employee:', err);
            return { success: false, error: err.message };
        }
    }, [loadEmployees]);

    /**
     * Delete an employee
     * @param {number} id - Employee ID
     */
    const removeEmployee = useCallback(async (id) => {
        try {
            await api.deleteEmployee(id);
            await loadEmployees(); // Refresh the list
            return { success: true };
        } catch (err) {
            console.error('Failed to delete employee:', err);
            return { success: false, error: err.message };
        }
    }, [loadEmployees]);

    // Load employees on mount
    useEffect(() => {
        loadEmployees();
    }, [loadEmployees]);

    return {
        // State
        employees,
        loading,
        error,
        // Actions
        loadEmployees,
        addEmployee,
        editEmployee,
        removeEmployee,
    };
}

export default useEmployees;
