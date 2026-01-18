import React, { useState, useCallback, useMemo } from 'react';
import './App.css';

// Custom hooks
import { useEmployees } from './hooks/useEmployees';

// Components
import EmployeeTable from './components/EmployeeTable';
import EmployeeModal from './components/EmployeeModal';

/**
 * Team Directory Application
 * 
 * Main application component that provides:
 * - Employee listing with search functionality
 * - CRUD operations via modal form
 * - Loading and error state handling
 */
function App() {
  // Employee data and operations from custom hook
  const {
    employees,
    loading,
    error,
    loadEmployees,
    addEmployee,
    editEmployee,
    removeEmployee
  } = useEmployees();

  // Local UI state
  const [searchTerm, setSearchTerm] = useState('');
  const [modalOpen, setModalOpen] = useState(false);
  const [modalMode, setModalMode] = useState('add');
  const [selectedEmployee, setSelectedEmployee] = useState(null);

  // Memoized filtered employees for performance
  const filteredEmployees = useMemo(() => {
    if (!searchTerm.trim()) return employees;

    const term = searchTerm.toLowerCase();
    return employees.filter((emp) => {
      const firstName = (emp.FIRSTNAME || emp.FirstName || '').toLowerCase();
      const lastName = (emp.LASTNAME || emp.LastName || '').toLowerCase();
      const role = (emp.ROLE || emp.Role || '').toLowerCase();

      return firstName.includes(term) ||
        lastName.includes(term) ||
        role.includes(term);
    });
  }, [employees, searchTerm]);

  // Open modal for adding new employee
  const handleAddClick = useCallback(() => {
    setModalMode('add');
    setSelectedEmployee(null);
    setModalOpen(true);
  }, []);

  // Open modal for editing employee
  const handleEditClick = useCallback((employee) => {
    setModalMode('edit');
    setSelectedEmployee(employee);
    setModalOpen(true);
  }, []);

  // Handle delete with confirmation
  const handleDeleteClick = useCallback(async (employee) => {
    const name = `${employee.FIRSTNAME || employee.FirstName} ${employee.LASTNAME || employee.LastName}`;
    const confirmed = window.confirm(`Are you sure you want to delete ${name}?`);

    if (confirmed) {
      const id = employee.ID || employee.id;
      const result = await removeEmployee(id);

      if (!result.success) {
        alert(`Failed to delete employee: ${result.error}`);
      }
    }
  }, [removeEmployee]);

  // Handle save from modal
  const handleSave = useCallback(async (formData, id) => {
    if (id) {
      return editEmployee(id, formData);
    }
    return addEmployee(formData);
  }, [addEmployee, editEmployee]);

  // Close modal
  const handleCloseModal = useCallback(() => {
    setModalOpen(false);
    setSelectedEmployee(null);
  }, []);

  return (
    <div className="container">
      <h1>Team Directory</h1>

      {/* Toolbar with search and add button */}
      <div className="toolbar">
        <div className="search-bar">
          <input
            type="text"
            placeholder="Search by name or role..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            aria-label="Search employees"
          />
        </div>
        <button className="btn-add" onClick={handleAddClick}>
          + Add Employee
        </button>
      </div>

      {/* Loading state */}
      {loading && (
        <div className="loading-container">
          <p className="loading">Loading employees...</p>
        </div>
      )}

      {/* Error state */}
      {error && (
        <div className="error-container">
          <p className="error">{error}</p>
          <button onClick={loadEmployees} className="btn-retry">
            Retry
          </button>
        </div>
      )}

      {/* Employee table */}
      {!loading && !error && (
        <>
          <p className="count">
            Showing {filteredEmployees.length} of {employees.length} employees
          </p>
          <EmployeeTable
            employees={filteredEmployees}
            onEdit={handleEditClick}
            onDelete={handleDeleteClick}
          />
        </>
      )}

      {/* Add/Edit Modal */}
      <EmployeeModal
        isOpen={modalOpen}
        mode={modalMode}
        employee={selectedEmployee}
        onSave={handleSave}
        onClose={handleCloseModal}
      />
    </div>
  );
}

export default App;
