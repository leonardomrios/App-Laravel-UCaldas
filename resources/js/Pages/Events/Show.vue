<template>
    <AppLayout title="Detalles del Evento">
        <template #header>
            <div class="flex justify-between items-center">
                <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                    {{ event.event_name }}
                </h2>
                <div class="flex space-x-2">
                    <Link
                        :href="route('events.edit', event.id)"
                        class="inline-flex items-center px-4 py-2 bg-indigo-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-indigo-700 active:bg-indigo-900 focus:outline-none focus:border-indigo-900 focus:ring focus:ring-indigo-300 disabled:opacity-25 transition"
                    >
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                        </svg>
                        Editar
                    </Link>
                    <button
                        @click="showDeleteModal = true"
                        class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700 active:bg-red-900 focus:outline-none focus:border-red-900 focus:ring focus:ring-red-300 disabled:opacity-25 transition"
                    >
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                        </svg>
                        Eliminar
                    </button>
                </div>
            </div>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-xl sm:rounded-lg">
                    <div class="p-6">
                        <!-- Información Principal del Evento -->
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <!-- Lado Izquierdo: Detalles del Evento -->
                            <div class="space-y-6">
                                <!-- Imagen del Evento -->
                                <div v-if="event.event_image" class="border-b border-gray-200 dark:border-gray-700 pb-4">
                                    <h3 class="text-lg font-medium leading-6 text-gray-900 dark:text-gray-100 mb-4">
                                        Imagen del Evento
                                    </h3>
                                    <div class="flex justify-center">
                                        <button @click="showImageModal = true" class="focus:outline-none">
                                            <img :src="'/storage/' + event.event_image" alt="Imagen del evento" class="max-w-full h-auto max-h-64 object-cover rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200 cursor-pointer">
                                        </button>
                                    </div>
                                </div>

                                <div class="border-b border-gray-200 dark:border-gray-700 pb-4">
                                    <h3 class="text-lg font-medium leading-6 text-gray-900 dark:text-gray-100 mb-4">
                                        Información del Evento
                                    </h3>
                                    
                                    <!-- Nombre del Evento -->
                                    <div class="mb-4">
                                        <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                            Nombre del Evento
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 dark:text-gray-200">
                                            {{ event.event_name }}
                                        </dd>
                                    </div>

                                    <!-- Fecha y Hora -->
                                    <div class="mb-4">
                                        <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                            Fecha y Hora
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 dark:text-gray-200">
                                            {{ formatDate(event.event_date) }}
                                        </dd>
                                    </div>

                                    <!-- Orador -->
                                    <div class="mb-4" v-if="event.event_speaker_name">
                                        <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                            Orador
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 dark:text-gray-200">
                                            {{ event.event_speaker_name }}
                                        </dd>
                                    </div>

                                    <!-- Tipo de Evento -->
                                    <div class="mb-4">
                                        <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                            Tipo de Evento
                                        </dt>
                                        <dd class="mt-1">
                                            <span 
                                                :class="event.event_is_virtual 
                                                    ? 'bg-blue-100 text-blue-800' 
                                                    : 'bg-green-100 text-green-800'"
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium"
                                            >
                                                <svg class="mr-1.5 h-2 w-2" :class="event.event_is_virtual ? 'text-blue-400' : 'text-green-400'" fill="currentColor" viewBox="0 0 8 8">
                                                    <circle cx="4" cy="4" r="3" />
                                                </svg>
                                                {{ event.event_is_virtual ? 'Virtual' : 'Presencial' }}
                                            </span>
                                        </dd>
                                    </div>
                                </div>
                            </div>

                            <!-- Lado Derecho: Información del Venue -->
                            <div class="space-y-6">
                                <div class="border-b border-gray-200 dark:border-gray-700 pb-4">
                                    <h3 class="text-lg font-medium leading-6 text-gray-900 dark:text-gray-100 mb-4">
                                        Información del Venue
                                    </h3>
                                    
                                    <div v-if="event.venue" class="space-y-4">
                                        <!-- Nombre del Venue -->
                                        <div class="mb-4">
                                            <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                                Nombre del Venue
                                            </dt>
                                            <dd class="mt-1 text-sm text-gray-900 dark:text-gray-200 font-medium">
                                                {{ event.venue.venue_name }}
                                            </dd>
                                        </div>

                                        <!-- Dirección -->
                                        <div class="mb-4" v-if="event.venue.venue_address">
                                            <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                                Dirección
                                            </dt>
                                            <dd class="mt-1 text-sm text-gray-900 dark:text-gray-200">
                                                {{ event.venue.venue_address }}
                                            </dd>
                                        </div>

                                        <!-- Capacidad Máxima -->
                                        <div class="mb-4">
                                            <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                                Capacidad Máxima
                                            </dt>
                                            <dd class="mt-1 text-sm text-gray-900 dark:text-gray-200">
                                                {{ event.venue.venue_max_capacity }} personas
                                            </dd>
                                        </div>

                                        <!-- Link al Venue -->
                                        <div class="mt-6">
                                            <Link
                                                :href="route('venues.show', event.venue.id)"
                                                class="inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm leading-4 font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                                            >
                                                <svg class="mr-2 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                                                </svg>
                                                Ver Detalles del Venue
                                            </Link>
                                        </div>
                                    </div>
                                    
                                    <div v-else class="text-sm text-gray-500 dark:text-gray-400 italic">
                                        No se ha asignado un venue a este evento.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Botones de Navegación -->
                        <div class="mt-8 pt-4 border-t border-gray-200 dark:border-gray-700">
                            <div class="flex justify-between">
                                <Link
                                    :href="route('events.index')"
                                    class="inline-flex items-center px-4 py-2 bg-gray-600 dark:bg-gray-700 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 dark:hover:bg-gray-600 active:bg-gray-900 focus:outline-none focus:border-gray-900 focus:ring focus:ring-gray-300 disabled:opacity-25 transition"
                                >
                                    <svg class="mr-2 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                                    </svg>
                                    Volver a Eventos
                                </Link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Imagen -->
        <DialogModal :show="showImageModal" @close="showImageModal = false" max-width="4xl">
            <template #title>
                Imagen del Evento: {{ event.event_name }}
            </template>

            <template #content>
                <div class="flex justify-center">
                    <img :src="'/storage/' + event.event_image" alt="Imagen completa del evento" class="max-w-full max-h-96 object-contain rounded-lg">
                </div>
            </template>

            <template #footer>
                <SecondaryButton @click="showImageModal = false">
                    Cerrar
                </SecondaryButton>
            </template>
        </DialogModal>

        <!-- Modal de Confirmación de Eliminación -->
        <DialogModal :show="showDeleteModal" @close="showDeleteModal = false">
            <template #title>
                Confirmar Eliminación
            </template>

            <template #content>
                ¿Estás seguro de que deseas eliminar el evento <strong>{{ event.event_name }}</strong>?
                Esta acción no se puede deshacer.
            </template>

            <template #footer>
                <SecondaryButton @click="showDeleteModal = false">
                    Cancelar
                </SecondaryButton>

                <DangerButton
                    class="ml-3"
                    @click="deleteEvent"
                    :class="{'opacity-25': isDeleting}"
                    :disabled="isDeleting"
                >
                    {{ isDeleting ? 'Eliminando...' : 'Eliminar Evento' }}
                </DangerButton>
            </template>
        </DialogModal>
    </AppLayout>
</template>

<script setup>
import { ref } from 'vue'
import { router } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
import DialogModal from '@/Components/DialogModal.vue'
import DangerButton from '@/Components/DangerButton.vue'
import SecondaryButton from '@/Components/SecondaryButton.vue'
import { Link } from '@inertiajs/vue3'

// Props
const props = defineProps({
    event: Object
})

// State
const showDeleteModal = ref(false)
const showImageModal = ref(false)
const isDeleting = ref(false)

// Methods
const formatDate = (dateString) => {
    if (!dateString) return 'No especificada'
    
    const date = new Date(dateString)
    
    const day = date.getDate().toString().padStart(2, '0')
    const month = (date.getMonth() + 1).toString().padStart(2, '0')
    const year = date.getFullYear()
    
    const hours = date.getHours().toString().padStart(2, '0')
    const minutes = date.getMinutes().toString().padStart(2, '0')
    
    return `${day}/${month}/${year} a las ${hours}:${minutes}`
}

const deleteEvent = () => {
    isDeleting.value = true
    
    router.delete(route('events.destroy', props.event.id), {
        onSuccess: () => {
            // Redirect se maneja automáticamente
        },
        onError: () => {
            isDeleting.value = false
        },
        onFinish: () => {
            showDeleteModal.value = false
        }
    })
}
</script>