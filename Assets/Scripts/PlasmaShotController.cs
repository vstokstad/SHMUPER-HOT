using UnityEngine;

public class PlasmaShotController : MonoBehaviour {
    public float plasmaDamage = 1f;
    private readonly string enemyTag = "Enemy";
    private ParticleSystem _particleSystem;

    private void Awake(){
        _particleSystem = GetComponent<ParticleSystem>();
    }

    private void OnEnable(){
        _particleSystem.Play();
        enabled = true;
    }

    private void OnDisable(){
        _particleSystem.Stop();
        enabled = true;
    }

    private void OnBecameInvisible(){
        gameObject.SetActive(false);
    }

    private void OnTriggerEnter(Collider other){
        if (other.gameObject.CompareTag(enemyTag)) {
            other.gameObject.GetComponent<EnemyController>().TakeDamage(plasmaDamage);
            //  _particleSystem.Simulate(0.1f);
            gameObject.SetActive(false);
        }
    }
}