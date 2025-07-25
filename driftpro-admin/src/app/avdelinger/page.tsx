'use client';

import { useState, useEffect } from 'react';

interface User {
  id: string;
  name: string;
  email: string;
  role: string;
  departmentId?: string;
}

interface Department {
  id: string;
  name: string;
  leaderId?: string;
  users: User[];
}

export default function AvdelingerPage() {
  const [departments, setDepartments] = useState<Department[]>([]);
  const [users, setUsers] = useState<User[]>([]);
  const [showAddModal, setShowAddModal] = useState(false);
  const [showEditModal, setShowEditModal] = useState(false);
  const [showUserModal, setShowUserModal] = useState(false);
  const [selectedDepartment, setSelectedDepartment] = useState<Department | null>(null);
  const [editingDepartment, setEditingDepartment] = useState<Partial<Department>>({});
  const [newDepartment, setNewDepartment] = useState({ name: '', leaderId: '' });

  // Mock data - i en ekte app ville dette komme fra en API
  useEffect(() => {
    const mockUsers: User[] = [
      { id: '1', name: 'Ola Nordmann', email: 'ola@driftpro.no', role: 'admin' },
      { id: '2', name: 'Kari Hansen', email: 'kari@driftpro.no', role: 'user' },
      { id: '3', name: 'Per Olsen', email: 'per@driftpro.no', role: 'user' },
      { id: '4', name: 'Anne Berg', email: 'anne@driftpro.no', role: 'user' },
      { id: '5', name: 'Erik Johansen', email: 'erik@driftpro.no', role: 'user' },
    ];

    const mockDepartments: Department[] = [
      {
        id: '1',
        name: 'Produksjon',
        leaderId: '1',
        users: [mockUsers[1], mockUsers[2]]
      },
      {
        id: '2',
        name: 'Vedlikehold',
        leaderId: '3',
        users: [mockUsers[3], mockUsers[4]]
      }
    ];

    setUsers(mockUsers);
    setDepartments(mockDepartments);
  }, []);

  const getLeaderName = (leaderId?: string) => {
    if (!leaderId) return 'Ikke satt';
    const leader = users.find(user => user.id === leaderId);
    return leader ? leader.name : 'Ikke funnet';
  };

  const getAvailableUsers = (departmentId?: string) => {
    return users.filter(user => !user.departmentId || user.departmentId === departmentId);
  };

  const handleAddDepartment = () => {
    if (newDepartment.name.trim()) {
      const department: Department = {
        id: Date.now().toString(),
        name: newDepartment.name,
        leaderId: newDepartment.leaderId || undefined,
        users: []
      };
      setDepartments([...departments, department]);
      setNewDepartment({ name: '', leaderId: '' });
      setShowAddModal(false);
    }
  };

  const handleEditDepartment = () => {
    if (editingDepartment.name?.trim() && selectedDepartment) {
      const updatedDepartments = departments.map(dept =>
        dept.id === selectedDepartment.id
          ? { ...dept, ...editingDepartment }
          : dept
      );
      setDepartments(updatedDepartments);
      setShowEditModal(false);
      setSelectedDepartment(null);
      setEditingDepartment({});
    }
  };

  const handleDeleteDepartment = (departmentId: string) => {
    if (confirm('Er du sikker på at du vil slette denne avdelingen?')) {
      setDepartments(departments.filter(dept => dept.id !== departmentId));
    }
  };

  const handleAddUserToDepartment = (userId: string, departmentId: string) => {
    const updatedUsers = users.map(user =>
      user.id === userId ? { ...user, departmentId } : user
    );
    setUsers(updatedUsers);
    
    const updatedDepartments = departments.map(dept =>
      dept.id === departmentId
        ? { ...dept, users: [...dept.users, updatedUsers.find(u => u.id === userId)!] }
        : dept
    );
    setDepartments(updatedDepartments);
  };

  const handleRemoveUserFromDepartment = (userId: string, departmentId: string) => {
    const updatedUsers = users.map(user =>
      user.id === userId ? { ...user, departmentId: undefined } : user
    );
    setUsers(updatedUsers);
    
    const updatedDepartments = departments.map(dept =>
      dept.id === departmentId
        ? { ...dept, users: dept.users.filter(user => user.id !== userId) }
        : dept
    );
    setDepartments(updatedDepartments);
  };

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      <div className="container mx-auto px-4 py-8">
        <header className="mb-8">
          <div className="flex justify-between items-center">
            <div>
              <a href="/" className="text-blue-400 hover:text-blue-300 mb-4 inline-block">
                ← Tilbake til dashboard
              </a>
              <h1 className="text-4xl font-bold mb-2">🏢 Avdelinger</h1>
              <p className="text-gray-400">Administrer avdelinger og brukere</p>
            </div>
            <button
              onClick={() => setShowAddModal(true)}
              className="bg-blue-600 hover:bg-blue-700 px-6 py-3 rounded-lg font-semibold transition-colors"
            >
              + Legg til avdeling
            </button>
          </div>
        </header>

        <main className="space-y-6">
          {departments.map((department) => (
            <div key={department.id} className="bg-gray-800 rounded-lg p-6">
              <div className="flex justify-between items-start mb-4">
                <div>
                  <h2 className="text-2xl font-semibold mb-2">{department.name}</h2>
                  <p className="text-gray-400">
                    Leder: {getLeaderName(department.leaderId)}
                  </p>
                  <p className="text-gray-400">
                    Antall brukere: {department.users.length}
                  </p>
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => {
                      setSelectedDepartment(department);
                      setShowUserModal(true);
                    }}
                    className="bg-green-600 hover:bg-green-700 px-4 py-2 rounded-lg transition-colors"
                  >
                    👥 Brukere
                  </button>
                  <button
                    onClick={() => {
                      setSelectedDepartment(department);
                      setEditingDepartment({ name: department.name, leaderId: department.leaderId });
                      setShowEditModal(true);
                    }}
                    className="bg-yellow-600 hover:bg-yellow-700 px-4 py-2 rounded-lg transition-colors"
                  >
                    ✏️ Rediger
                  </button>
                  <button
                    onClick={() => handleDeleteDepartment(department.id)}
                    className="bg-red-600 hover:bg-red-700 px-4 py-2 rounded-lg transition-colors"
                  >
                    🗑️ Slett
                  </button>
                </div>
              </div>

              {department.users.length > 0 && (
                <div className="mt-4">
                  <h3 className="text-lg font-semibold mb-2">Brukere i avdelingen:</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-2">
                    {department.users.map((user) => (
                      <div key={user.id} className="bg-gray-700 p-3 rounded-lg flex justify-between items-center">
                        <div>
                          <p className="font-medium">{user.name}</p>
                          <p className="text-sm text-gray-400">{user.email}</p>
                        </div>
                        <button
                          onClick={() => handleRemoveUserFromDepartment(user.id, department.id)}
                          className="text-red-400 hover:text-red-300 text-sm"
                        >
                          Fjern
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          ))}

          {departments.length === 0 && (
            <div className="text-center py-12">
              <p className="text-gray-400 text-lg">Ingen avdelinger funnet</p>
              <p className="text-gray-500">Klikk "Legg til avdeling" for å komme i gang</p>
            </div>
          )}
        </main>

        {/* Add Department Modal */}
        {showAddModal && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div className="bg-gray-800 p-6 rounded-lg w-full max-w-md">
              <h2 className="text-2xl font-bold mb-4">Legg til ny avdeling</h2>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium mb-2">Avdelingsnavn</label>
                  <input
                    type="text"
                    value={newDepartment.name}
                    onChange={(e) => setNewDepartment({ ...newDepartment, name: e.target.value })}
                    className="w-full p-3 bg-gray-700 rounded-lg border border-gray-600 focus:border-blue-500 focus:outline-none"
                    placeholder="Skriv avdelingsnavn"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium mb-2">Avdelingsleder (valgfritt)</label>
                  <select
                    value={newDepartment.leaderId}
                    onChange={(e) => setNewDepartment({ ...newDepartment, leaderId: e.target.value })}
                    className="w-full p-3 bg-gray-700 rounded-lg border border-gray-600 focus:border-blue-500 focus:outline-none"
                  >
                    <option value="">Velg leder</option>
                    {users.map((user) => (
                      <option key={user.id} value={user.id}>
                        {user.name}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="flex gap-3">
                  <button
                    onClick={handleAddDepartment}
                    className="flex-1 bg-blue-600 hover:bg-blue-700 py-3 rounded-lg font-semibold transition-colors"
                  >
                    Legg til
                  </button>
                  <button
                    onClick={() => setShowAddModal(false)}
                    className="flex-1 bg-gray-600 hover:bg-gray-700 py-3 rounded-lg font-semibold transition-colors"
                  >
                    Avbryt
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* Edit Department Modal */}
        {showEditModal && selectedDepartment && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div className="bg-gray-800 p-6 rounded-lg w-full max-w-md">
              <h2 className="text-2xl font-bold mb-4">Rediger avdeling</h2>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium mb-2">Avdelingsnavn</label>
                  <input
                    type="text"
                    value={editingDepartment.name || ''}
                    onChange={(e) => setEditingDepartment({ ...editingDepartment, name: e.target.value })}
                    className="w-full p-3 bg-gray-700 rounded-lg border border-gray-600 focus:border-blue-500 focus:outline-none"
                    placeholder="Skriv avdelingsnavn"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium mb-2">Avdelingsleder</label>
                  <select
                    value={editingDepartment.leaderId || ''}
                    onChange={(e) => setEditingDepartment({ ...editingDepartment, leaderId: e.target.value })}
                    className="w-full p-3 bg-gray-700 rounded-lg border border-gray-600 focus:border-blue-500 focus:outline-none"
                  >
                    <option value="">Velg leder</option>
                    {users.map((user) => (
                      <option key={user.id} value={user.id}>
                        {user.name}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="flex gap-3">
                  <button
                    onClick={handleEditDepartment}
                    className="flex-1 bg-yellow-600 hover:bg-yellow-700 py-3 rounded-lg font-semibold transition-colors"
                  >
                    Lagre endringer
                  </button>
                  <button
                    onClick={() => setShowEditModal(false)}
                    className="flex-1 bg-gray-600 hover:bg-gray-700 py-3 rounded-lg font-semibold transition-colors"
                  >
                    Avbryt
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* Manage Users Modal */}
        {showUserModal && selectedDepartment && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div className="bg-gray-800 p-6 rounded-lg w-full max-w-2xl max-h-[80vh] overflow-y-auto">
              <h2 className="text-2xl font-bold mb-4">
                Administrer brukere - {selectedDepartment.name}
              </h2>
              
              <div className="space-y-6">
                {/* Current Users */}
                <div>
                  <h3 className="text-lg font-semibold mb-3">Brukere i avdelingen</h3>
                  {selectedDepartment.users.length > 0 ? (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                      {selectedDepartment.users.map((user) => (
                        <div key={user.id} className="bg-gray-700 p-3 rounded-lg flex justify-between items-center">
                          <div>
                            <p className="font-medium">{user.name}</p>
                            <p className="text-sm text-gray-400">{user.email}</p>
                          </div>
                          <button
                            onClick={() => handleRemoveUserFromDepartment(user.id, selectedDepartment.id)}
                            className="text-red-400 hover:text-red-300 text-sm"
                          >
                            Fjern
                          </button>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <p className="text-gray-400">Ingen brukere i denne avdelingen</p>
                  )}
                </div>

                {/* Available Users */}
                <div>
                  <h3 className="text-lg font-semibold mb-3">Legg til brukere</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                    {getAvailableUsers(selectedDepartment.id).map((user) => (
                      <div key={user.id} className="bg-gray-700 p-3 rounded-lg flex justify-between items-center">
                        <div>
                          <p className="font-medium">{user.name}</p>
                          <p className="text-sm text-gray-400">{user.email}</p>
                        </div>
                        <button
                          onClick={() => handleAddUserToDepartment(user.id, selectedDepartment.id)}
                          className="text-green-400 hover:text-green-300 text-sm"
                        >
                          Legg til
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              <div className="mt-6">
                <button
                  onClick={() => setShowUserModal(false)}
                  className="w-full bg-gray-600 hover:bg-gray-700 py-3 rounded-lg font-semibold transition-colors"
                >
                  Lukk
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
} 